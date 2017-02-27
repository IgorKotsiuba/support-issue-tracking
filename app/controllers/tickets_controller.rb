class TicketsController < ApplicationController
  respond_to :html

  before_action :set_ticket, only: [:show, :edit, :update]
  before_action :set_status, only: [:create, :update]

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = @status.tickets.new(permitted_params.except(:message))
    message = @ticket.messages.new(permitted_params[:message])

    @ticket.transaction do
      message.save
      TicketCreationNotifierWorker.perform_async(@ticket.id) if @ticket.save
    end
    respond_with(@ticket, location: root_url)
  end

  def show
    respond_with(@ticket)
  end

  def edit
    respond_with(@ticket)
  end

  def update
    @ticket.update(permitted_params.merge(status: @status))
    respond_with(@ticket)
  end

  private

  def permitted_params
    params.require(:ticket).permit(:customer_name, :customer_email, :issue_department, :subject, :url_token,
                                   message: :body)
  end

  def set_ticket
    @ticket ||= Ticket.find_by_url_token(params[:url_token])
  end

  def set_status
    @status ||= Status.find_by_name('Waiting for Staff Response')
  end
end
