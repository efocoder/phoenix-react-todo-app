defmodule TodoApiWeb.Paginator do
  def paginate(meta, resource) do
    %{
      number_of_pages: meta.total_pages,
      record_count: meta.total_count,
      next_page:
        if(meta.has_next_page?,
          do:
            Flop.Phoenix.build_path(
              "#{TodoApiWeb.Endpoint.url()}/api/v1/#{resource}/",
              %{meta.flop | page: meta.next_page, limit: nil}
            )
        ),
      prev_page:
        if(meta.has_previous_page?,
          do:
            Flop.Phoenix.build_path(
              "#{TodoApiWeb.Endpoint.url()}/api/v1/#{resource}",
              %{meta.flop | page: meta.previous_page, limit: nil}
            )
        )
    }
  end
end