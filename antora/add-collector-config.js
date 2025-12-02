module.exports.register = function () {
  this.once('contentAggregated', ({ contentAggregate, playbook }) => {
    const outDir = `output/artifacts`

    for (const { origins } of contentAggregate) {
      for (const origin of origins) {

        let collector = {
          run: {
            command: "just generate-documentation",
            env: [
              {
                'name': 'NAME',
                'value': origin.descriptor.name
              },
              {
                'name': 'OUT',
                'value': outDir
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
