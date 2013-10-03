<div class="row-fluid">
	<div class="span12">
		<div class="widget-box">
			<div class="widget-title">

				 <h5>List {model|label|plural}</h5>
				<div class="buttons">
					<a title="Add a new {model|lower}" class="btn btn-success btn-mini" href="/admin/{model|url}"><i class="icon-plus icon-white"></i> Add New</a>
				</div>
			</div>
			<div class="widget-content nopadding">
				<table class="table table-bordered table-striped with-check">
					<thead>
						<tr>
							<th class="header"><input type="checkbox" id="title-checkbox" name="title-checkbox" /></th>
							<th class="header" rel="{model|lower}.{model|col}_id">#</th>
							{table_headers}
				            <th class="header" rel="{model|lower}.created">Created</th>
				            <th class="header">Action</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach($this->data->rows() AS $key=>$value){ ?>
						<tr>
							<td><input type="checkbox" /></td>
							<td><?php echo $value['{model|col}_id']; ?></td>
							{table_rows}
				            <td><?php echo date("m/d/y", strtotime($value['created'])); ?></td>
				            <td>
				            	<a href="/admin/{model|url}/id/<?php echo $value[$this->primary]; ?>" class="btn btn-primary btn-mini"><i class="icon-pencil icon-white"></i> View</a>
				            	<a href="/admin/delete/?model={model}&id=<?php echo $value[$this->primary];; ?>" rel="model={model}|id=<?php echo $value[$this->primary]; ?>" class="btn btn-danger btn-mini trig_delete"><i class="icon-remove icon-white"></i> Delete</a>
				            </td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>
		</div>
		<?php echo $this->pager($this->data->pager(), 'partials/pager/pager.phtml'); ?>
	</div>
</div>