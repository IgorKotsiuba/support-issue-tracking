class Admin::MessagesController < Admin::BaseController
  respond_to :html

  def create
    ticket = Ticket.find(params[:ticket_id])
    message = ticket.messages.new(permitted_params.except(:ticket))

    message.transaction do
      message.save
      # TicketResponseNotifierWorker.perform_async(@ticket.id) if @ticket.update(permitted_params[:ticket])
      ticket.update(permitted_params[:ticket])
    end
    respond_with(ticket, location: admin_ticket_path(ticket.id))
  end

  private

  def permitted_params
    params.require(:message).permit(:body, ticket: [:user_id, :status_id])
  end
end
