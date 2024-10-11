class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about]
  def top
  end

  def about
  # ここにアクションの処理を記述
  end

end
