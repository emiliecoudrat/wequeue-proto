class LinesController < ApplicationController
  def index
    @lines = policy_scope(Line)
  end
end
