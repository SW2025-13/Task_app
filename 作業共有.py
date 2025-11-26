viewで作業⇒mainに入れる⇒共有

1.作業者
git checkout view(作業する所)   # 個人作業ブランチへ移動

（作業）

git add .
git commit -m "作業内容"
git push origin view

2.レビュー or チーム合意後、main に取り込む

main に切り替えて merge

git switch main
git pull origin main
git merge view(作業してた場所)
git push origin main

3.他のメンバー
git switch main
git pull origin main


git switch view_page