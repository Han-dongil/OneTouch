var Grid = tui.Grid;

Grid.applyTheme('default', {
	cell: {
		normal: {
			border: '#FFFFFF'
		},
		header: {
			background: '#4B49AC',
			text: '#fff'
		}
	},
	row: {
		hover: {
			background: '#eeeeff'
		}
	}
});
Grid.setLanguage('ko');

/* Grid.setLanguage('ko', {
  	display: {
        noData: 'No data.',
        loadingData: 'Loading data.',
        resizeHandleGuide: 'You can change the width of the column by mouse drag, ' +
                            'and initialize the width by double-clicking.'
    },
    net: {
        confirmCreate: 'Are you sure you want to create {{count}} data?',
        confirmUpdate: 'Are you sure you want to update {{count}} data?',
        confirmDelete: 'Are you sure you want to delete {{count}} data?',
        confirmModify: 'Are you sure you want to modify {{count}} data?',
        noDataToCreate: 'No data to create.',
        noDataToUpdate: 'No data to update.',
        noDataToDelete: 'No data to delete.',
        noDataToModify: '반품처리할 내용을 입력해 주세요.',
        failResponse: 'An error occurred while requesting data.\nPlease try again.'
    }
}); */
