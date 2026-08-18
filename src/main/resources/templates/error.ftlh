<#import "main.ftlh" as main>

<@main.page title="Ошибка ${status!500}">
    <div class="row justify-content-center my-5">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-lg border-danger">
                <div class="card-header bg-danger text-white d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">⚠️ ${errorTitle!"Произошла ошибка"}</h4>
                    <span class="badge bg-dark fs-6">${status!500}</span>
                </div>
                <div class="card-body text-light">
                    <p class="card-text fs-5">${message!"Произошла непредвиденная ошибка."}</p>

                    <hr class="border-secondary">

                    <div class="text-secondary small">
                        <#if path??>
                            <p class="mb-1"><strong>Путь вызова:</strong> <code>${path}</code></p>
                        </#if>
                        <#if timestamp??>
                            <p class="mb-0"><strong>Время:</strong> ${timestamp}</p>
                        </#if>
                    </div>
                </div>
                <div class="card-footer bg-black border-secondary d-flex justify-content-between">
                    <a href="javascript:history.back()" class="btn btn-outline-secondary">Назад</a>
                    <a href="/boss" class="btn btn-danger">В кабинет Босса</a>
                </div>
            </div>
        </div>
    </div>
</@main.page>