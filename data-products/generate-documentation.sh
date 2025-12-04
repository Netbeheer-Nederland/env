#!/bin/env bash

export name=$(grep -sPo '(?<=name: ).*$' ./model/*.linkml.yml | tr -d '\n' | tr '-' '_')
export title=$(grep -sPo '(?<=title: ).*$' ./model/*.linkml.yml | tr -d '\n' | tr '-' '_')
export version=$(grep -sPo '(?<=version: ).*$' ./model/*.linkml.yml | tr -d '\n' | tr '-' '_')

function generate_documentation() {
    echo "Generating documentation…"
    echo
    mkdir -p $OUTDIR
    cp -r documentation/* $OUTDIR
    yq -i '.version = env(version)' $OUTDIR/antora.yml
    yq -i '.title = env(title)' $OUTDIR/antora.yml
    echo
    echo "Generating schema documentation…"
    echo
    mkdir -p "$OUTDIR/modules/schema"
    python -m linkml_asciidoc_generator.main \
        -o $OUTDIR/modules/schema \
        -t /opt/data-products/templates \
        --render-diagrams \
        model/$name.linkml.yml
    echo "Adding schema documentation to nav…"
    yq -i '.nav += ["modules/schema/nav.adoc"]' $OUTDIR/antora.yml
    echo
    echo -e "Copying generated artifacts to schema documentation…"
    for model in model/*; do \
        cp -r $model $OUTDIR/modules/schema/attachments/; \
        echo -e "To reference use:\n\txref:schema:attachment$"${model#model/}"[]"; \
    done
    echo -e "Copy examples (JSON) to schema documentation…"
    for example in examples/*.yml; do \
        example_name=$(basename $example); \
        gen-linkml-profile  \
            convert \
            "$example" \
            --out "$OUTDIR/modules/schema/attachments/${example_name%.*}.json"; \
        echo -e "To reference use:\n\txref:schema:attachment\$${example_name%.*}.json[]"; \
    done
    echo
}

generate_documentation
