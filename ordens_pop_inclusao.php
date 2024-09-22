<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>

     <!-- janela Modal para inclusão de registro -->
     <div class="modal fade" class="modal-dialog modal-lg" id="novoModal" name="novoModal" tabindex="-1" role="dialog" aria-labelledby="novoModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Inclusão de nova Oficina</h4>
                </div>
                <div class="modal-body">
                    <div class='alert alert-warning' role='alert'>
                        <h5>Campos com (*) são obrigatórios</h5>
                    </div>
                    <form id="frmadd" action="">
                        <div class="mb-3 row">
                            <label for="add_descricaoField" class="col-md-3 form-label">Oficina (*)</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" id="add_descricaoField" name="add_dscricaoField">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary"><span class='glyphicon glyphicon-floppy-saved'></span> Salvar</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal"><span class='glyphicon glyphicon-remove'></span> Fechar</button>

                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
    
</body>
</html>