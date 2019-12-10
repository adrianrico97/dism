class TrackingsController < ApplicationController
  include SessionsModule

  def new
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.find(params[:issue_id])
    @tracking = @issue.trackings.build
  end

  def create
    @device = acc.devices.find(params[:device_id])
    @issue = @device.issues.find(params[:issue_id])
    @tracking = @issue.trackings.build(tracking_params)
    @tracking.user = current_user
    @tracking.date = Time.now
    if @issue.save
      redirect_to device_issue_path(@device, @issue)
    else
      render 'new'
    end
  end

  private
  def tracking_params
    params.require(:tracking).permit(:description)
  end

end
