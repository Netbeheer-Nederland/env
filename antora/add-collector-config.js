module.exports.register = function () {
  this.once('contentAggregated', ({ contentAggregate, playbook }) => {
    const outDir = "output/adoc"

    for (const { origins } of contentAggregate) {
      for (const origin of origins) {

        /* TODO: Get these from the LinkML schema. */
        const model = {
            name: "capaciteitskaart",
            title: "Capaciteitskaart",
            version: origin.refname
        }

        let collector = {
          run: {
            command: `/antora/generate-documentation.sh`,
            env: [
              {
                'name': 'NAME',
                'value': model.name
              },
              {
                'name': 'TITLE',
                'value': model.title
              },
              {
                'name': 'VERSION',
                'value': model.version
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
