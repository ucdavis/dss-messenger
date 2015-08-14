class ModifiersController < ApplicationController
  before_action :set_modifier, only: [:show, :edit, :update, :destroy]

  filter_resource_access

  def create
    @modifier = Modifier.new(modifier_params)

    respond_to do |format|
      if @modifier.save
        format.html { redirect_to @modifier, notice: 'Modifier was successfully created.' }
        format.json { render json: @modifier, status: :created, location: @modifier }
      else
        format.html { render action: "new" }
        format.json { render json: @modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @modifier.update_attributes(modifier_params)
        format.html { redirect_to @modifier, notice: 'Modifier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @modifier.destroy

    respond_to do |format|
      format.html { redirect_to modifiers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modifier
      @modifier = Modifier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modifier_params
      params.require(:modifier).permit(:description, :open_ended)
    end
end
