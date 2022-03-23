function strGenerator(length) {
	var ch = 'a';
	var txt = "";
	for (var i = 1; i <= parseInt(length); i++) {
		txt += ch;
	}
	return txt;
}
