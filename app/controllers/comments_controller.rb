class CommentsController < ApplicationController
    before_action :authenticate_user!
      
        def create
          post = Post.find(params[:post_id])
          comment = post.comments.build(comment_params) 
          comment.user_id = current_user.id
          if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path) 
          else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path) 
        end
    end
    def destroy
      comment = Comment.find(params[:id])
      if comment.destroy
        redirect_to post_path(params[:post_id])
      else
        flash.now[:alert] = 'コメント削除に失敗しました'
        render post_path(params[:post_id])
      end
    end
    
    
      
        private
        def set_post
          @post = Post.find(params[:post_id])
        end
      
          def comment_params
            params.require(:comment).permit(:content)
          end
      end
    