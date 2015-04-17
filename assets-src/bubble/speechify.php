<?
//bubble.php - create a "speech bubble" around a given input image.
// first, get size. 
$b =  $_REQUEST['b'];
$bp = $_REQUEST['bp'];

function LoadPNG($imgname)
{
    // Attempt to open 
    $im = @imagecreatefrompng($imgname);

    // See if it failed 
    if(!$im)
    {
        // Create a blank image 
        $im  = imagecreatetruecolor(150, 30);
        $bgc = imagecolorallocate($im, 255, 255, 255);
        $tc  = imagecolorallocate($im, 0, 0, 0);

        imagefilledrectangle($im, 0, 0, 800, 30, $bgc);

        // Output an error message 
        imagestring($im, 1, 5, 5, 'Error loading ' . $imgname, $tc);
    }

    return $im;
}


if($b == "down") { 
	// the pointer is down. 
	$dir = "bot";
} else { 
	$dir = "top";
}
if($bp <= 40) { 
	$s = "l";
} elseif($bp >= 60) { 
	$s = "r";
} else { 
	$s = "c";
}
$pname = $s."-".$dir.".png";
$pt = LoadPNG($pname); 
// got the pointer. 
// now build step 1 - the background
$bgt = LoadPNG("bg.png"); 

$img = LoadPNG("http://shmups.info/fontgen/arcade.php/y-aura/z-4/cs-0.0.0/x-Super%20Lastius%20II");

$width = imagesx($img);
$height = imagesy($img);



$step1 = imagecreatetruecolor($width+4, $height+8);
imagesavealpha($step1,true);
imagecopyresized($step1, $bgt, 0,0,0,0,$width+4, $height+8,imagesx($bgt),imagesy($bgt));
imagecopy($step1,$img,2,4,0,0,$width,$height);
$widthb = imagesx($step1);
$heightb= $height+8;
$step2 = imagecreatetruecolor($widthb +8, $heightb);
imagesavealpha($step2,true);
$bg = imagecolorallocatealpha($step2,255,255,255,127);
imagefill($step2,0,0,$bg);
imagecopy($step2,$step1,4,0,0,0,$widthb,$heightb);
$lft = LoadPNG('l-end.png');
$rgt = LoadPNG('r-end.png');
imagecopy($step2,$lft,0,0,0,0,4,16);
imagecopy($step2,$rgt,$widthb+4,0,0,0,4,16);


$step3 = imagecreatetruecolor(imagesx($step2), imagesy($step2)+8);
imagesavealpha($step3,true);
$bg = imagecolorallocatealpha($step3,255,255,255,127);
imagefill($step3,0,0,$bg);
if($b == "up") { 
	$voffset = 8;
	$poffset = 0;
} else { 
	$voffset = 0;
	$poffset = imagesy($step2) - 2;	
}

$xpos = floor($width * ($bp/100)) + 4;
imagecopy($step3,$step2,0,$voffset,0,0,imagesx($step2), imagesy($step2));
imagecopy($step3,$pt,$xpos,$poffset,0,0,imagesx($pt),imagesy($pt));
header("Content-Type: image/png");

imagepng($step3);

?>
