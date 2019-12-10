class IssuesController < ApplicationController
  include SessionsModule

  def show
    @issue = acc.issues.find(params[:id])
  end

  def new
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.build(:user => current_user, :date => Date.today)
  end

  def create
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.build(issue_params)
    @issue.user = current_user
    @issue.priority ||= ISSUE_PRIORITIES[:normal]
    @issue.state ||= ISSUE_STATES[:open]
    if @issue.save
      redirect_to device_issue_path(@device, @issue)
    else
      render 'new'
    end
  end

  def edit
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.find(params[:id])
  end

  def update
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.find(params[:id])
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to device_issue_path(@device, @issue) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.find(params[:id])
    @issue.trash!
    redirect_to device_path(@device)
  end

  private
  def issue_params
    params.require(:issue).permit(:title, :description, :date, :state, :priority)
  end

end
