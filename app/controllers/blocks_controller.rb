class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit, :update, :destroy]


  def index
    @blocks = user.blocks.load
  end

  def show
  end

  def new
    @block = Block.new
  end


  def create
    @block = Block.new(block_params)
    @block.blocker_id = current_user.id
    @block.save!
  end

  def destroy
    @block.destroy
  end

  private

    def set_block
      @block = Block.find(params[:id])
    end


    def block_params
      params.require(:block).permit(:blockable, :blockable)
    end
end
