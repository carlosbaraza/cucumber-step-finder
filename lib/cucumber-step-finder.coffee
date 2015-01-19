CucumberStepFinderView = require './cucumber-step-finder-view'
{CompositeDisposable} = require 'atom'

module.exports = CucumberStepFinder =
  cucumberStepFinderView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cucumberStepFinderView = new CucumberStepFinderView(state.cucumberStepFinderViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cucumberStepFinderView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cucumber-step-finder:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cucumberStepFinderView.destroy()

  serialize: ->
    cucumberStepFinderViewState: @cucumberStepFinderView.serialize()

  toggle: ->
    console.log 'CucumberStepFinder was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
