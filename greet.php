<?php
//echo htmlspecialchars( "hi " . $_GET['name'], ENT_QUOTES, "utf-8");

$res = array(
  "message" => htmlspecialchars( "hi " . $_GET['namae'], ENT_QUOTES, "utf-8"),
  "length" => strlen($_GET['namae'])
);

  header('Content-Type: application/json; charset=utf-8');
  echo json_encode( $res );
?>
