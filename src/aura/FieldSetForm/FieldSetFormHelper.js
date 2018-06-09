({ createForm: function(cmp) {
        console.log('FieldSetFormHelper.createForm');
        var fields = cmp.get('v.fields');
        var obj = cmp.get('v.record');
        var inputDesc = [];
        var fieldPaths = [];
        for (var i = 0; i < fields.length; i++) {
            var field = fields[i];
            var config = this.configMap[field.type.toLowerCase()];
            if (config) {
                config.attributes.label = field.label;
                config.attributes.required = field.required;
                config.attributes.value = obj[field.fieldPath];
                config.attributes.fieldPath = field.fieldPath;
                inputDesc.push([
                    config.componentDef,
                    config.attributes
                ]);
                fieldPaths.push(field.fieldPath);
            } else {
                console.log('type ' + field.type.toLowerCase() + ' not supported');
            }
        }

        $A.createComponents(inputDesc, function(cmps) {
            console.log('createComponents');
            var inputToField = {};
            for (var i = 0; i < fieldPaths.length; i++) {
                cmps[i].addHandler('change', cmp, 'c.handleValueChange');
                inputToField[cmps[i].getGlobalId()] = fieldPaths[i];
            }
            cmp.set('v.form', cmps);
            cmp.set('v.inputToField', inputToField);
        });
    }
})