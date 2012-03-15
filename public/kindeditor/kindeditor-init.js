KindEditor.ready(function(K) {
	var arr = [
		'#goal_knowledge',
		'#goal_ability',
		'#goal_emotion',
		'#unit_emphasis',
		'#teaching_emphasis',
		'#teaching_difficulty',
		'#teaching_method',
		'#teaching_ready'
	];
	for(var i=0; i<arr.length; i++)
	{
		K.create(arr[i], {
			width: "99%",
			resizeType: 1,
			allowFileManager: true,
			uploadJson: '/kindeditor/upload',
			fileManagerJson: '/kindeditor/filemanager',
			items : [
									'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
									'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
									'insertunorderedlist', '|', 'emoticons', 'image', 'link']
		});
	}
	
	// arr = [
	// 	'#process_teacher_',
	// 	'#process_stu_',
	// 	'#process_idea_',
	// 	'#evaluate_blackboard_',
	// 	'#summary_homework_',
	// 	'#thinking_'
	// ];
	// 
	// for(var c=0; c<10; c++)
	// {
	// 	for(var i=0; i<arr.length; i++)
	// 	{
	// 		var height = '200px';
	// 		if ( '#process_teacher_' == arr[i] || '#process_stu_' == arr[i] || '#process_idea_' == arr[i] ) {
	// 			height = '600px';
	// 		}
	// 		K.create(arr[i]+c, {
	// 			width: "99%",
	// 			height: height,
	// 			allowFileManager: true,
	// 			uploadJson: '/kindeditor/upload',
	// 			fileManagerJson: '/kindeditor/filemanager',
	// 			items : [
	// 									'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
	// 									'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
	// 									'insertunorderedlist', '|', 'emoticons', 'image', 'link']
	// 		});
	// 	}
	// }
});