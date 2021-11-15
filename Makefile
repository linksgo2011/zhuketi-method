work_dir=docs
source=${work_dir}/*.md
include_dir=build
filename=zhuketi-method
title='软件哲学：计算机软件中的主客体'

clear:
	rm -f ${work_dir}/$(filename).md

# combine chapters to one file
combine: clear
	awk 'FNR==1{print ""}{print}' $(source) > ${work_dir}/$(filename).md

epub: combine
	pandoc ${work_dir}/$(filename).md -o $(filename).epub --resource-path ${work_dir} \
    --epub-metadata $(include_dir)/metadata.xml \
    --css $(include_dir)/epub.css \
    --title-prefix $(title) \
    --toc

word: combine
	pandoc ${work_dir}/$(filename).md -o $(filename).docx --resource-path ${work_dir} \
    --epub-metadata $(include_dir)/metadata.xml \
    --css $(include_dir)/epub.css \
    --title-prefix $(title) \
    --toc

html: combine
	pandoc ${work_dir}/$(filename).md -o index.html --resource-path ${work_dir} \
    --css $(include_dir)/html.css \
    --title-prefix $(title) \
    --toc
