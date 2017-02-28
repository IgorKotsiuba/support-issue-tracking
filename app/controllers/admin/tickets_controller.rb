class Admin::TicketsController < Admin::BaseController
  respond_to :html

  def index
    tickets = params[:ticket].present? ? Ticket.search_by_params(permitted_params) : Ticket.all
    @tickets = tickets.order(updated_at: :desc)
    respond_with(@tickets)
  end

  def show
    @ticket = Ticket.find(params[:id])
    respond_with(@ticket)
  end

  private

  def permitted_params
    params.require(:ticket).permit(:reference_number, :subject, :status)
  end
end
