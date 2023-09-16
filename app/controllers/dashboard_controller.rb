class DashboardController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!, except: [:index]
  after_action :verify_authorized, except: [:index]

  def index
  end

  def new
    authorize :dashboard, :new?
  end

  def edit
    authorize :dashboard, :edit?
  end
end
