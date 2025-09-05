SHELL := /bin/bash
DIR ?= .
TF ?= terraform
AUTOAPPROVE ?= true
VARS ?=
BACKEND ?=

.PHONY: fmt init validate plan apply destroy output show graph workspace

fmt:
	@$(TF) fmt -recursive

init:
	@cd $(DIR) && $(TF) init $(BACKEND)

validate:
	@cd $(DIR) && $(TF) validate

plan:
	@cd $(DIR) && $(TF) plan $(VARS)

apply:
	@cd $(DIR) && if [ "$(AUTOAPPROVE)" = "true" ]; then $(TF) apply -auto-approve $(VARS); else $(TF) apply $(VARS); fi


# !!!!

destroy:
	@cd $(DIR) && if [ "$(AUTOAPPROVE)" = "true" ]; then $(TF) destroy -auto-approve $(VARS); else $(TF) destroy $(VARS); fi

# !!!!

output:
	@cd $(DIR) && $(TF) output

show:
	@cd $(DIR) && $(TF) show

graph:
	@cd $(DIR) && $(TF) graph > graph.dot && echo "Wrote $(DIR)/graph.dot (render: dot -Tpng graph.dot > graph.png)"

workspace:
	@cd $(DIR) && $(TF) workspace list
