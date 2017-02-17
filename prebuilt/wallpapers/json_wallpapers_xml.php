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
		} else {
			$output[] = array("filename"=>$file, "timestamp"=>filemtime($path.'/'.$file));
		}
	}

	return $output;
}

function parse_wallpapers_xml($wallpapers_xml_path) {

	$output = array();
	$wallpapers_xml = simplexml_load_file($wallpapers_xml_path);
	foreach ($wallpapers_xml->wallpaper as $wallpaper) {
		$attributes = current($wallpaper->attributes());
		$filename = $attributes["filename"];
		$output[(string)$filename]=$attributes;
	}
	return $output;
}

function enrich_file_list_with_wallpapers_xml($file_list,$wallpapers_xml) {
	$output = array();
	foreach($file_list as $file) {
		$filename = $file["filename"];
		if(array_key_exists($filename,$wallpapers_xml)) {
			$output[] = array_merge($file,
					$wallpapers_xml[$filename]);
		} else {
			$output[] = $file;
		}
	}
	return $output;
}

//chdir("../");
$file_list = list_files(".");
$wallpapers_xml = parse_wallpapers_xml("."."/wallpapers.xml");

$output = enrich_file_list_with_wallpapers_xml($file_list,$wallpapers_xml);
echo json_encode($output);

?>

