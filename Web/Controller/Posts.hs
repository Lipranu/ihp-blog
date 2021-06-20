module Web.Controller.Posts where

import Web.Controller.Prelude
import Web.View.Posts.Index
import Web.View.Posts.New
import Web.View.Posts.Edit
import Web.View.Posts.Show

import qualified Text.MMark as MMark

instance Controller PostsController where
  action PostsAction = do
      posts <- query @Post
        |> orderByDesc #createdAt
        |> fetch
      render IndexView { .. }

  action NewPostAction = do
      let post = newRecord
      render NewView { .. }

  action ShowPostAction { postId } = do
      post <- fetch postId
        >>= pure . modify #comments (orderByDesc #createdAt)
        >>= fetchRelated #comments
      render ShowView { .. }

  action EditPostAction { postId } = do
      post <- fetch postId
      render EditView { .. }

  action UpdatePostAction { postId } = do
      post <- fetch postId
      post
        |> buildPost
        |> ifValid \case
          Left post -> render EditView { .. }
          Right post -> do
            post <- post |> updateRecord
            setSuccessMessage "Post updated"
            redirectTo EditPostAction { .. }

  action CreatePostAction = do
      let post = newRecord @Post
      post
        |> buildPost
        |> ifValid \case
          Left post -> render NewView { .. }
          Right post -> do
            post <- post |> createRecord
            setSuccessMessage "Post created"
            redirectTo PostsAction

  action DeletePostAction { postId } = do
      post <- fetch postId
      deleteRecord post
      setSuccessMessage "Post deleted"
      redirectTo PostsAction

buildPost
  :: ( HasField "meta"  a MetaBag
     , HasField "title" a value
     , HasField "body"  a Text
     , SetField "body"  a fieldType1
     , SetField "meta"  a MetaBag
     , SetField "title" a fieldType2
     , ParamReader fieldType1
     , ParamReader fieldType2
     , IsEmpty value
     , ?context::ControllerContext
     )
  => a
  -> a
buildPost post = post
    |> fill @["title","body"]
    |> validateField #title nonEmpty
    |> validateField #body nonEmpty
    |> validateField #body isMarkdown

isMarkdown :: Text -> ValidatorResult
isMarkdown text = case MMark.parse "" text of
    Left _ -> Failure "Please provide valid Markdown"
    Right _ -> Success
