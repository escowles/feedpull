class ReposController < ApplicationController
  def create
    @repo = Repo.new(params.require(:repo).permit(:name, :user_id))

    respond_to do |format|
      if @repo.save
        format.html { redirect_to root_path, notice: 'Repo was successfully created.' }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :new }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repo = Repo.find(params[:id])
    @repo.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
