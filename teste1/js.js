<script>
let createDataGrid = (options, $container) => {
    const dataGridElement = ($container || $("#dataGrid")).dxDataGrid(options);
    QUnit.assert.ok(dataGridElement);
    const dataGrid = dataGridElement.dxDataGrid("instance");
    return dataGrid;
};
 
QUnit.module("DataGrid", function () {
    QUnit.test("DataGrid is initialized and displays data", function (assert) {
    // act
    const dataGrid = createDataGrid({
        dataSource: {
        pageSize: 3,
        store: [{ id: 1 }, { id: 2 }, { id: 3 }, { id: 4 }],
        },
    });
 
    // assert
    assert.equal($("#dataGrid").find(".dx-data-row").length, 3);
    });
});

</script>
