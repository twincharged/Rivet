class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def index
    @notifications = current_user.notifications.all
  end

  def show
  end

  def destroy
    @notification.destroy
  end

  private

    def set_notification
      @notification = Notification.find(params[:id])
    end


    def notification_params
      params[:notification]
    end
end
