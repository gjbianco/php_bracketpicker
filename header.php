<?php include("meta.php"); ?>
    <link rel="stylesheet" href="css/frontend.css"></link>
    <!--link rel="stylesheet" href="css/bootstrap-theme.min.css"></link-->

  </head>
  <body>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-main">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#page-top">
            <img class="brand-image" alt="Brand" src="img/basketball_icon.png" /><?php echo $meta['title']; ?>
          </a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse-main">
          <ul class="nav navbar-nav navbar-right">
            <li>
              <a href="index.php">HOME</a>
            </li>
            <li>
              <a href="submit.php">CREATE BRACKET</a>
            </li>
            <li>
              <a href="rules.php">RULES</a>
            </li>
            <li>
              <a href="choose.php">STANDINGS</a>
            </li>
<?php if($meta['cost'] != 0) { ?>
            <li>
              <a href="paid.php">PAYMENT TRACKER</a>
            </li>
<?php } ?>
<?php if($meta['mail'] != 0 ) { ?>
            <li>
              <a href="contact.php">CONTACT</a>
            </li>
<?php } ?>
          </ul>
        </div>
      </div>
    </nav>
