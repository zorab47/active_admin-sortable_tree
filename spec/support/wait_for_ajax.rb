module WaitForAjax
  def wait_for_ajax(count = 1)
    page.execute_script 'window._ajaxCalls = 0, window._ajaxCompleteCounter = function() { window._ajaxCalls += 1; }'
    page.execute_script '$(document).on("ajaxComplete", window._ajaxCompleteCounter)'

    yield

    Timeout.timeout(Capybara.default_wait_time) do
      loop until finished_all_ajax_requests?(count)
    end

    page.execute_script '$(document).off("ajaxComplete", window._ajaxCompleteCounter)'
    page.execute_script 'delete window._ajaxCompleteCounter, window._ajaxCalls'
  end

  def finished_all_ajax_requests?(count)
    page.evaluate_script('window._ajaxCalls') == count
  end
end
