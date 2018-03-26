class BlogMailer < ApplicationMailer
  def blog_mail(blog)
   @blog = blog #ブログ投稿した人の情報をViewファイルに渡すことがでる

   mail to: @blog.user.email, subject: "ブログ投稿完了メール"
  end
end
