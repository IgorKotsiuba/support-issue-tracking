class Admin::TicketsController < Admin::BaseController
  def index
    tickets = params[:ticket].present? ? Ticket.search_by_params(permitted_params) : Ticket.all
    @tickets = tickets.order(updated_at: :desc)
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def edit
  end

  private

  def permitted_params
    params.require(:ticket).permit(:reference_number, :subject, :status)
  end
end
