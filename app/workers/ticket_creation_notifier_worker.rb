class TicketCreationNotifierWorker
  include Sidekiq::Worker

  def perform(ticket)
    TicketMailer.confirming_notification(ticket).deliver
  end
end
