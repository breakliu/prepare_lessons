total_lesson_hours = 0;

jQuery(function($) {
  window.NestedFormEvents = function() {
    this.addFields = $.proxy(this.addFields, this);
    this.removeFields = $.proxy(this.removeFields, this);
  };

  NestedFormEvents.prototype = {
    addFields: function(e) {
			// if ( total_lesson_hours == 10 ) {
			// 	alert('已到达最大课时数')
			// 	return false;
			// }
      // Setup
      var link    = e.currentTarget;
      var assoc   = $(link).attr('data-association');            // Name of child
      var content = $('#' + assoc + '_fields_blueprint .fields div').html(); // Fields template

      // Make the context correct by replacing new_<parents> with the generated ID
      // of each of the parent objects
      var context = ($(link).closest('.fields').find('input:first').attr('name') || '').replace(new RegExp('\[[a-z]+\]$'), '');

      // context will be something like this for a brand new form:
      // project[tasks_attributes][new_1255929127459][assignments_attributes][new_1255929128105]
      // or for an edit form:
      // project[tasks_attributes][0][assignments_attributes][1]
      if (context) {
        var parentNames = context.match(/[a-z_]+_attributes/g) || [];
        var parentIds   = context.match(/(new_)?[0-9]+/g) || [];

        for(var i = 0; i < parentNames.length; i++) {
          if(parentIds[i]) {
            content = content.replace(
              new RegExp('(_' + parentNames[i] + ')_.+?_', 'g'),
              '$1_' + parentIds[i] + '_');

            content = content.replace(
              new RegExp('(\\[' + parentNames[i] + '\\])\\[.+?\\]', 'g'),
              '$1[' + parentIds[i] + ']');
          }
        }
      }

      // Make a unique ID for the new child
      var regexp  = new RegExp('new_' + assoc, 'g');
      var new_id  = new Date().getTime();
      content     = content.replace(regexp, "new_" + new_id);

			var tmp = [ 
				'process_teacher_',
				'process_stu_',
				'process_idea_',
				'evaluate_blackboard_',
				'summary_homework_',
				'thinking_'
			];
			for ( var i=0; i<tmp.length; i++ ) {
					content = content.replace(tmp[i], tmp[i] + '_' + new_id);
			}

      var field = this.insertFields(content, assoc, link);
      $(link).closest("form")
        .trigger({ type: 'nested:fieldAdded', field: field })
        .trigger({ type: 'nested:fieldAdded:' + assoc, field: field });

			$(content).find("textarea").each(function(index){
				var height = '200px';
				if ( index <= 2 ) {
					height = '600px';
				}
				KindEditor.create('textarea[id="'+$(this).attr("id")+'"]', {
					width: "99%",
					resizeType: 1,
					height: height,
					allowFileManager: true,
					uploadJson: '/kindeditor/upload',
					fileManagerJson: '/kindeditor/filemanager',
					items : [
			      'undo', 'redo', '|', 'cut', 'copy', 'paste',
			      'plainpaste', 'wordpaste', '|', 'subscript', 'superscript', 'clearhtml', '|',
			      'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
			      'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 
						'image','insertfile', 'table', '|', 'fullscreen', 'source'
					]
				});
			});
			
      return false;
    },
    insertFields: function(content, assoc, link) {
      //return $(content).insertBefore(link);
			total_lesson_hours++;
			//alert(content);
			$('<li><a href="#tab'+total_lesson_hours+'" data-toggle="tab">第'+total_lesson_hours+'课时</a></li>').appendTo('#lesson_hours-tab-menu');
			return $('<div class="tab-pane" id="tab'+total_lesson_hours+'">'+content+'</div>').appendTo('#lesson_hours-tab-content');
    },
    removeFields: function(e) {
      var link = e.currentTarget;
      var hiddenField = $(link).prev('input[type=hidden]');
      hiddenField.val('1');
			
      var field = $(link).closest('.fields');
      field.hide();
      $(link).closest("form").trigger({ type: 'nested:fieldRemoved', field: field });		

			////////////////////////////////////////////////////// 删除当前课时
			var tab = hiddenField.parent();
			var li = $('a[href="#'+tab.attr("id")+'"]').parent();
			var input = li.next();
			tab.hide();
			li.hide();
			if ( input.attr("type") == "hidden" ) {
				input.hide();
			}
			/////////////////////////////////////////////////////
      return false;
    }
  };

  window.nestedFormEvents = new NestedFormEvents();
  $('form a.add_nested_fields').live('click', nestedFormEvents.addFields);
  $('form a.remove_nested_fields').live('click', nestedFormEvents.removeFields);
});
