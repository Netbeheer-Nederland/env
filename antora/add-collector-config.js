const path = require('path')


module.exports.register = function () {
  this.once('contentAggregated', ({ contentAggregate, playbook }) => {
    const outDir = "output/adoc"
    const modelName = path.basename(process.cwd());

    for (const { origins } of contentAggregate) {
      for (const origin of origins) {

        origin.descriptor.name = modelName;
        origin.descriptor.title = modelName.toUpperCase();

        let collector = {
          run: {
            command: `/antora/generate-documentation.sh`,
            env: [
              {
                'name': 'NAME',
                'value': origin.descriptor.name
              }
            ]
          },
          scan: {
            clean: true,
            dir: outDir
          }
        }

        Object.assign((origin.descriptor.ext ??= {}), { collector })
      }
    }
  })
}
