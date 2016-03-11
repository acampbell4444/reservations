class UpdateReservationMailer < ApplicationMailer
  default from: "alantest44@gmail.com"

  def update_reservation(reservation)

      # headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
       #headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
       #headers["References"] = "<post/#{post.id}@your-app-name.example>"
      @reservation = reservation
       #@post = post


       mail(to: "#{@reservation.customer_email}", subject: "Parasail reservation no. #{@reservation.id}")
     end

  end
