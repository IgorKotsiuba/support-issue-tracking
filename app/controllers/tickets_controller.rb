class TicketsController < ApplicationController
  respond_to :html

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Status.find_by_name('Waiting for Staff Response').tickets.new(permitted_params.except(:message))
    message = @ticket.messages.new(permitted_params[:message])

    @ticket.transaction do
      message.save
      TicketCreationNotifierWorker.perform_async(@ticket.id) if @ticket.save
    end
    respond_with(@ticket, location: root_url)
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def permitted_params
    params.require(:ticket).permit(:customer_name, :customer_email, :issue_department, :subject, message: :body)
  end
end
