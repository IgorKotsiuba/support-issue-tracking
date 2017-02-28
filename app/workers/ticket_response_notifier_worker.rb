class TicketResponseNotifierWorker
  include Sidekiq::Worker

  def perform(ticket)
    TicketMailer.response_notification(ticket).deliver
  end
end
