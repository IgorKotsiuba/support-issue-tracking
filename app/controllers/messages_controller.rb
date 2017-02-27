class MessagesController < ApplicationController
  respond_to :html

  def create
    ticket = Ticket.find_by_url_token(params[:ticket_url_token])
    respond_with(ticket) if ticket.messages.create(permitted_params)
  end

  private

  def permitted_params
    params.require(:message).permit(:body)
  end
end
