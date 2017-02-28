class TicketMailer < BaseMailer
  def confirming_notification(ticket_id)
    @ticket = Ticket.find(ticket_id)
    mail(to: @ticket.customer_email, subject: 'Ticket request confirmation')
  end

  def response_notification(ticket_id)
    @ticket = Ticket.find(ticket_id)
    mail(to: @ticket.customer_email, subject: 'Ticket request response')
  end
end
