# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Notifications
	constructor: ->
		@notifications = $("[data-behavior='notifications']")
		@setup() if @notifications.length > 0

		@notificationList = $("[data-behavior='notification-list']")
		@listen() if @notificationList.length > 0
	setup: ->
		self=@
		#$("[data-behavior='notifications-link']").on "click", @handleClick	

		$("#top").delegate("[data-behavior='notifications-link']", "click", @handleClick)
		$("#top").delegate(".joinBtn", "click", @joinClick)	
		
		(worker = ->
		  $.ajax
		    url: "/notifications.json"
		    dataType: "JSON"
		    method: "GET"
		    success:self.handleSuccess
		    complete: ->
		      setTimeout worker, 10000

		)()



	listen: ->
		$("#top").delegate(".join", "click", @join)	


		

	join: (e) -> 
		or_id= $( this ).attr( "orderId" )
		us_id= $( this ).attr( "userId" )
		own_id= $( this ).attr( "ownerId" )
		$.ajax(
			url: "/ordetails/join"
			dataType: "JSON"
			data:{order_id:or_id , user_id:us_id, creator_id:own_id}
			method: "POST"
		)

		window.location.href = 'http://localhost:3000/orders/'+or_id+'/ordetails/new'		



	joinClick: (e) -> 
		or_id= $( this ).attr( "orderId" )
		us_id= $( this ).attr( "userId" )
		own_id= $( this ).attr( "ownerId" )
		$.ajax(
			url: "/ordetails/join"
			dataType: "JSON"
			data:{order_id:or_id , user_id:us_id, creator_id:own_id}
			method: "POST"

		)		
		window.location.href = 'http://localhost:3000/orders/'+or_id+'/ordetails/new'




	handleClick: (e) -> 
		$.ajax(
			url: "/notifications/mark_as_read"
			dataType: "JSON"
			method: "POST"
			success: ->
				$("[data-behavior='unread-count']").text(0)
				$("[id='rounded']").css("background", "#36424a")	
		)


	handleSuccess: (data) ->
		console.log(data)
		items = $.map data, (notification)	->
				if notification.action is 'joined'
					"<li><span style='display:inline-block;' >#{notification.actor}  #{notification.action} your </span><a class='btn btn-primary' style='display:inline-block;'  href='#{notification.url}'> #{notification.notifiable.for} order</a></li>"
				else if	notification.action is 'created'
					"<li><span style='display:inline-block;' >#{notification.actor}  #{notification.action} a </span><a class='btn btn-primary' style='display:inline-block;'  href='#{notification.url}'> #{notification.notifiable.for} order</a></li>"
				else
					"<li><span style='display:inline-block;' >#{notification.actor}  #{notification.action} you for </span><a class='btn btn-primary' style='display:inline-block;'  href='#{notification.url}'> #{notification.notifiable.for} order</a><button style='display:inline-block;' class='btn btn-success joinBtn' orderId='#{notification.notifiable.id}' ownerId='#{notification.actorid}' userId='#{notification.recipient.id}'>Join</button></li>"



		if(items.length)!=0
			$("[id='rounded']").css("background", "red")
		$("[data-behavior='unread-count']").text(items.length)	
		$("[data-behavior='notification-items']").html(items)	
		$("[data-behavior='notification-items']").append("<li><a href='/notifications'>See All Notifications</a></li>")	

jQuery ->
	new Notifications		