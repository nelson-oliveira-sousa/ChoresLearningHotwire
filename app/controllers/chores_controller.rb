class ChoresController < ApplicationController
  before_action :set_chore, only: %i[ show edit update destroy ]
  after_action :broadcast_insert, only: %i[create]
  after_action :broadcast_remove, only: %i[destroy]

  def index
    @chores = Chore.all
    @chore = Chore.new
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(chore_params)

    respond_to do |format|
      if @chore.save
        format.turbo_stream
        format.html { redirect_to @chore, notice: 'Chore was successfully created.'}
        format.json { render :show, status: :created, location: @chore}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chore.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @chore.destroy
    respond_to do |format|
      format.turbo_stream # include this
      format.html { redirect_to chores_url, notice: "Chore was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

  def broadcast_insert
    return if @chore.errors.any?
    Turbo::StreamsChannel.broadcast_append_to(
      "chores",
      target: "chores",
      partial: "chores/chore",
      locals: { chore: @chore }
    )
  end

  def broadcast_remove
    return unless @chore.destroyed?
    Turbo::StreamsChannel.broadcast_remove_to(
      "chores",
      target: ActionView::RecordIdentifier.dom_id(@chore)
    )
  end

  def set_chore
    @chore = Chore.find(params[:id])
  end

  def chore_params
    params.require(:chore).permit(:title, :content)
  end
end
