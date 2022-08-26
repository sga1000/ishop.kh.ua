<div class="module">
    <h3><?php echo $heading_title; ?></h3>
    <h4><?php echo $description; ?></h4>
    
    <div class="category-tree-box">
        <div class="category-tree-carousel ">
            <?php foreach ($categories as $category) { ?>
            <div class="category-block">
                    <div class="image">
                    <?php if ($category['image']) { ?>
                        <a href="<?php echo $category['href'];?>" title="<?php echo $category['name']; ?>">
                            <img src="<?php echo $category['image']; ?>" width="200" height="200" alt="<?php echo $category['name']; ?>"/>
                        </a>
                    <?php } ?>
                    </div>
                   
        
                    <div class="list-box">
                        <a href="<?php echo $category['href']; ?>">
                            <?php echo $category['name']; ?>
                        </a>
                    </div>
            </div>
            <?php } ?>
        </div>
    </div>
</div>

<script>
  $(document).ready(function() {
    $('.category-tree-carousel').owlCarousel({
        items : 1,
        responsive : {
            480 : { items : 1  },
            768 : { items : 2  },
            1024 : { items : 4},
            1200 : { items : 5, nav: true}
        },
        nav: true,
        dots: false
    });

    
  })
</script>