class ModifiersController < ApplicationController
  filter_resource_access
  
  def create
    @modifier = Modifier.new(params[:modifier])

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
    @modifier = Modifier.find(params[:id])

    respond_to do |format|
      if @modifier.update_attributes(params[:modifier])
        format.html { redirect_to @modifier, notice: 'Modifier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @modifier = Modifier.find(params[:id])
    @modifier.destroy

    respond_to do |format|
      format.html { redirect_to modifiers_url }
      format.json { head :no_content }
    end
  end
end
