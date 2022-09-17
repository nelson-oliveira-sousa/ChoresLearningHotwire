class ChoresController < ApplicationController
  def index
    @chores = Chore.all
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


  private

  def chore_params
    params.require(:chore).permit(:title, :content)
  end
end
