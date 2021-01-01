class TasksController < ApplicationController
    
    def index
        @board = Board.find(params[:board_id])
        @tasks = Task.all
    end

    def show
        board = Board.find(params[:board_id])
        @task = board.tasks.find(params[:id])
    end

    def new
        board = Board.find(params[:board_id])
        @task = board.tasks.build
        @task.user = current_user
    end

    def create
        board = Board.find(params[:board_id])
        @task = board.tasks.build(task_params)
        @task.user = current_user

        if @task.save
            redirect_to board_tasks_path(board), notice: '投稿しました'
        else 
            flash.now[:error] = '投稿に失敗しました'
            render :new
        end
    end

    def edit
        board = Board.find(params[:board_id])
        @task = board.tasks.find(params[:id])
        @task.user = current_user
    end

    def update
        board = Board.find(params[:board_id])
        @task = board.tasks.find(params[:id])
        @task.user = current_user
        if @task.update(task_params)
            redirect_to board_task_path(@task.board), notice: '更新しました'
        else 
            flash.now[:error] = '更新に失敗しました'
            render :edit
        end
    end

    def destroy
        board = Board.find(params[:board_id])
        task = board.tasks.find(params[:id])
        task.user = current_user
        task.destroy!
        redirect_to board_tasks_path(board)
    end

    private
    def task_params
        params.require(:task).permit(:name,:description)
    end

end