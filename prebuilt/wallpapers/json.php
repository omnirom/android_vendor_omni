<?php

function list_files($path) {
	$output = array();
	$files = scandir($path);
	if ($path == "./_h5ai" || $path == "./.bak") return $output;

	foreach ($files as $file) {
		if ($file == "." || $file == ".." || strpos($file, '.html')
			|| $file == ".bak" || $file == "_h5ai") {
			continue;
		}

		if (is_dir($path.'/'.$file)) {
			$output[$path.'/'.$file] = list_files($path.'/'.$file);
		} else {
			$output[] = array("filename"=>$file, "timestamp"=>filemtime($path.'/'.$file));
		}
	}

	return $output;
}

//chdir("../");
echo json_encode(list_files("."));




?>

