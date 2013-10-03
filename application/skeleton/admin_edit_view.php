<div class="row-fluid">
	<div class="span12">
		<div class="widget-box">
			<div class="widget-title">
				<span class="icon">
					<i class="icon-align-justify"></i>
				</span>
				<h5>{model|ucfirst} form</h5>
			</div>

			<div class="widget-content nopadding">
				<form action="/admin/data" method="POST" class="trig_save form-horizontal">
				<input type="hidden" name="model" value="{model}">
		  		<input type="hidden" name="id" value="<?php echo $this->params('id'); ?>">

		  			{edit_fields}

					<div class="form-actions">
						<input type="submit" class="btn btn-success primary" value="Save changes">&nbsp;<button type="reset" class="btn back">Cancel</button>
					</div>

				</form>
			</div>
		</div>
	</div>
</div>

<script>


$(document).ready(function(){

	$('select[name=type]').change(function(){

		if($(this).val() == "Add"){

			$('#type_new_box').show();
			$('select[name=type]').attr('name', 'type_old');
			$('#type_new').attr('name', 'type');

		}else{

			$('#type_new_box').hide();
			$('select[name=type]').attr('name', 'type');
			$('#type_new').attr('name', 'type_old');

			$.getJSON("/api/categories", {type: $(this).val()}, function(res){
				$('select[name=parent_id]').html(res.result.html);
				console.log(res);
			});
		}
	});
});
</script>