class CommentsController < ApplicationController
    def new
        @board = Board.find(params[:board_id])
        @task = Task.find(params[:task_id])
        @comment = @task.comments.build
        @comment.user = current_user
    end

    def create
        @board = Board.find(params[:board_id])
        task = Task.find(params[:task_id])
        @comment = task.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            redirect_to board_task_path(board_id: @board.id, id: task.id), notice: 'コメントしました'
        else 
            flash.now[:error] = 'コメントに失敗しました'
            render :new
        end
    end

    private 
    def comment_params
        params.require(:comment).permit(:description)
    end
end